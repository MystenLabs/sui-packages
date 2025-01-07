module 0xf20d91ac1cb592473c760442a0bd59096e4cac29bdecc0e5895fbb9e770f6741::TESTING {
    struct TESTING has drop {
        dummy_field: bool,
    }

    struct TESTINGStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<TESTING>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct TESTINGAdminCap has key {
        id: 0x2::object::UID,
    }

    struct MinterAdded has copy, drop {
        id: 0x2::object::ID,
    }

    struct MinterRemoved has copy, drop {
        id: 0x2::object::ID,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<TESTING>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTING>>(arg0, arg1);
    }

    public fun burn(arg0: &mut TESTINGStorage, arg1: 0x2::coin::Coin<TESTING>) : u64 {
        0x2::balance::decrease_supply<TESTING>(&mut arg0.supply, 0x2::coin::into_balance<TESTING>(arg1))
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING>(arg0, 9, b"TESTING", b"SSQUID", b"Join with us web : https://TESTING.xyz , tg : @TESTINGportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmRo3EAbeNajei7Q1tsY778W4BBfy2SvrcFCmJPKVZUfhN?_gl=1*1coko6v*rs_ga*NGMxYTE0YzUtNjg3OS00MTMxLThhM2EtMGZiMjljNzQ2OWYz*rs_ga_5RMPXG14TE*MTY4MzI4ODI5My4xLjEuMTY4MzI4ODQ5Mi40OC4wLjA")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TESTING>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTING>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTING>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

