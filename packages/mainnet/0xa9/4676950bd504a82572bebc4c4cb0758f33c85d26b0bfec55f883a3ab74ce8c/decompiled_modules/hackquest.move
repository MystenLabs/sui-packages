module 0xa94676950bd504a82572bebc4c4cb0758f33c85d26b0bfec55f883a3ab74ce8c::hackquest {
    struct HACKQUEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACKQUEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACKQUEST>(arg0, 9, b"HQ", b"HackQuest", b"this is hackquest coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACKQUEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACKQUEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<HACKQUEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HACKQUEST>>(0x2::coin::mint<HACKQUEST>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

