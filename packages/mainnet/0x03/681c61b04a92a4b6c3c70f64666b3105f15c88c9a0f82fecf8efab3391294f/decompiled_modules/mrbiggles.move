module 0x3681c61b04a92a4b6c3c70f64666b3105f15c88c9a0f82fecf8efab3391294f::mrbiggles {
    struct MRBIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRBIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRBIGGLES>(arg0, 6, b"MRBIGGLES", b"DEEZ NUTS MR BIGGLESWORTH", b"Sometimes I sit around and let my nutz hang low. Holding the world ransom for 1 million dollars. Fire the lazers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_202049_643_38619afae2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRBIGGLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRBIGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

