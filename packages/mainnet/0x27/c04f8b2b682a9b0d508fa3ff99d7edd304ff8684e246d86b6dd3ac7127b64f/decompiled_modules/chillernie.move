module 0x27c04f8b2b682a9b0d508fa3ff99d7edd304ff8684e246d86b6dd3ac7127b64f::chillernie {
    struct CHILLERNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLERNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLERNIE>(arg0, 9, b"CHILLERNIE", b"Just a chill Ernie", b"Just a chill Ernie token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreif2f6km3scbzrx6amly4qervemktoutrqy4xwv2lt5cevans73nxu.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHILLERNIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLERNIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLERNIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

