module 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx {
    struct AIPX has drop {
        dummy_field: bool,
    }

    struct AIPXStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<AIPX>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<AIPX>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AIPX>>(arg0, arg1);
    }

    fun init(arg0: AIPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPX>(arg0, 9, b"aIPX", b"Interest Protocol Airdrop IOU", b"An IOU of the Interest Protocol Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        let v2 = AIPXStorage{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<AIPX>(v0),
        };
        0x2::transfer::share_object<AIPXStorage>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIPX>>(v1);
    }

    public(friend) fun mint(arg0: &mut AIPXStorage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<AIPX> {
        if (total_supply(arg0) + arg1 >= 20000000000000000) {
            return 0x2::coin::zero<AIPX>(arg2)
        };
        0x2::coin::from_balance<AIPX>(0x2::balance::increase_supply<AIPX>(&mut arg0.supply, arg1), arg2)
    }

    public fun total_supply(arg0: &AIPXStorage) : u64 {
        0x2::balance::supply_value<AIPX>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

