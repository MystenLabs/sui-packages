module 0x342a978832cb7211c75713808f15c0888825b926b4942966e8816fd772590d9a::ilk {
    struct ILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILK>(arg0, 6, b"ILK", b"Infinity Links", b"Infinity Links is a Sui-based token designed to foster seamless connections and infinite possibilities within the blockchain ecosystem. Built on stability and scalability, Infinity Links empowers holders with innovative features and rewards, paving the way for a connected and limitless future in decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000388_1165fc7639.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILK>>(v1);
    }

    // decompiled from Move bytecode v6
}

