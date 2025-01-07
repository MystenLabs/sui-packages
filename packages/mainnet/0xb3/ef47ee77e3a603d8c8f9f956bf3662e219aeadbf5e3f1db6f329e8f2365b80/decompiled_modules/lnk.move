module 0xb3ef47ee77e3a603d8c8f9f956bf3662e219aeadbf5e3f1db6f329e8f2365b80::lnk {
    struct LNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LNK>(arg0, 9, b"LNK", b"Link", b"Link is a groundbreaking cryptocurrency that facilitates seamless connections between decentralized applications. By leveraging advanced blockchain technology, it enhances security and efficiency, empowering developers and users to create a more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4e2dcc5-dbcf-4aef-8048-c78ec9dff8e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

