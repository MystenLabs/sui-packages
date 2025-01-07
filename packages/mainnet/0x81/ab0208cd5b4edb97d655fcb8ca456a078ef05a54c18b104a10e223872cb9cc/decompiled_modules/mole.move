module 0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole {
    struct MOLE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        treasuryCap: 0x2::coin::TreasuryCap<MOLE>,
        package_version: u64,
    }

    struct MoleCoinInfo has key {
        id: 0x2::object::UID,
        manual_minted: u64,
    }

    public entry fun burn(arg0: &mut AdminCap, arg1: &mut 0x2::coin::Coin<MOLE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x2::coin::burn<MOLE>(&mut arg0.treasuryCap, 0x2::coin::split<MOLE>(arg1, arg2, arg3));
    }

    public fun mint(arg0: &mut AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MOLE> {
        checked_package_version(arg0);
        let v0 = &mut arg0.treasuryCap;
        assert!(0x2::balance::supply_value<MOLE>(0x2::coin::supply<MOLE>(v0)) + arg1 < cap(), 2);
        0x2::coin::mint<MOLE>(v0, arg1, arg2)
    }

    public fun cap() : u64 {
        8000000000000000
    }

    public fun checked_package_version(arg0: &AdminCap) {
        assert!(arg0.package_version == 1, 6);
    }

    fun init(arg0: MOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLE>(arg0, 8, b"MOLE", b"Mole Token", b"MOLE is the native token of Mole Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tiecflm5c7sqxqme3fwhaxlelfdlfkkl4vluuh2invq6kk4ycyda.arweave.net/mggirZ0X5QvBhNlscF1kWUayqUvlV0ofSG1h5SuYFgY")), arg1);
        let v2 = AdminCap{
            id              : 0x2::object::new(arg1),
            treasuryCap     : v0,
            package_version : 1,
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = MoleCoinInfo{
            id            : 0x2::object::new(arg1),
            manual_minted : 0,
        };
        0x2::transfer::share_object<MoleCoinInfo>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOLE>>(v1);
    }

    public fun manual_mint(arg0: &mut AdminCap, arg1: &mut MoleCoinInfo, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(arg1.manual_minted + arg3 <= 3600000000000000, 3);
        arg1.manual_minted = arg1.manual_minted + arg3;
        mint_to(arg0, arg2, arg3, arg4);
    }

    public fun mint_to(arg0: &mut AdminCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = mint(arg0, arg2, arg3);
        if (0x2::coin::value<MOLE>(&v0) == 0) {
            0x2::coin::destroy_zero<MOLE>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<MOLE>>(v0, arg1);
        };
    }

    public entry fun upgrade_package_version(arg0: &mut AdminCap, arg1: u64) {
        arg0.package_version = arg1;
    }

    // decompiled from Move bytecode v6
}

