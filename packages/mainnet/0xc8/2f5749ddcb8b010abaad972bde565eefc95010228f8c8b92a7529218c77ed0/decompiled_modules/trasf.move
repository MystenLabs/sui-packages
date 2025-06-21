module 0xc82f5749ddcb8b010abaad972bde565eefc95010228f8c8b92a7529218c77ed0::trasf {
    struct TRASF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRASF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRASF>(arg0, 8, b"TRASF", b"TRASHPAD", b"TRASHPAD on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/220cd3c3-6b82-4b88-93ab-428bf2f4bc3c.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRASF>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRASF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRASF>>(v1);
    }

    // decompiled from Move bytecode v6
}

