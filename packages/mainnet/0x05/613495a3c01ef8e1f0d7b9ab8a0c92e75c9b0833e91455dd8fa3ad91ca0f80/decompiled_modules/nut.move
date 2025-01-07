module 0x5613495a3c01ef8e1f0d7b9ab8a0c92e75c9b0833e91455dd8fa3ad91ca0f80::nut {
    struct NUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUT>(arg0, 9, b"NUT", b"NUT NUT", b"NUT NUT NUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreifbs4dcpkseagu5vvjpztxjzx7m3sxk7zfcc5qpr4miwt3ogdeh3i.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

