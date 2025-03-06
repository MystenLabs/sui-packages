module 0x6260b06ca6a7ec0315c6ae736f651348117d5218439c41e643d768cad234d793::skf {
    struct SKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKF>(arg0, 6, b"SKF", b"Sui King Fizh", b"The character King Fizh was inspired by the fish Scomberomorus Cavalla, also known as Carite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070313_d3941d41cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

