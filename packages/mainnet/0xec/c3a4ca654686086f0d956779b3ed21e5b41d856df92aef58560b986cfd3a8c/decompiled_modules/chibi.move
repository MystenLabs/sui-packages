module 0xecc3a4ca654686086f0d956779b3ed21e5b41d856df92aef58560b986cfd3a8c::chibi {
    struct CHIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIBI>(arg0, 6, b"CHIBI", b"CHIBI NO NEKO", b"Chibi on the Sui blockchain, designed to embody the principles of mentorship, growth, and innovation. Inspired by the wisdom of a sensei, Chibi aims to guide users through their blockchain journey, offering a platform where education, collaboration, and empowerment are at the forefront. With a focus on inclusivity and decentralized governance, Chibi invites everyone to be part of an exciting and dynamic financial revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/56756756_173873733a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

