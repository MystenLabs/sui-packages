module 0x6596b343663c630960c9e67eb1f34c51fc66669fbd39aab97fc0fc5aea4c6fd2::kos {
    struct KOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOS>(arg0, 6, b"KoS", b"KIKI on SUI", b"KIKI on SUI, Ape in! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/30167_D8_F_2_B70_4_C68_826_A_6946742_C8_E05_1d0af57c4e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

