module 0xd4d564dbe33f0c39a8ca325433cae1700c41912c36a5f3137a86cfce10d9e023::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"Hop", b"Hop", b"Swap on @SuiNetwork for the best price with zero fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plum-accurate-ermine-64.mypinata.cloud/ipfs/Qmc2bN4ceeWnZszWww9ZRv8MM2cv54EjVXDgNLt3k5o5M9")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HOP>>(0x2::coin::mint<HOP>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOP>>(v2);
    }

    // decompiled from Move bytecode v6
}

