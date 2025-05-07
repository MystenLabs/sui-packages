module 0x2b05821c6fcfb79cd2a153f191ab6151b8080419bab544ad1f8b2967628eed85::sui_guy {
    struct SUI_GUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_GUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_GUY>(arg0, 6, b"Sui Guy", b"The Real Sui Guy", x"576520617265207265616c20616e642072656d656d6265722074686520747275746820616c7761797320636f6d6573206f75742e0a57656c636f6d6520746f20746865206e657720476f64206f6620537569204d656d6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigvgo73iajmawz24hc5uky5xly6qic7t4uztmwo3kits6c2lt4q5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_GUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI_GUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

