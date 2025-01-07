module 0x7abaa332f764d23a4ced62fc505b2a562f833ac2414ec2cd107b45fd49486246::aly {
    struct ALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALY>(arg0, 9, b"ALY", x"e29da4efb88f20414c59", b"I love you so much Aly!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-live.nmas.com.mx/nmas-news/styles/corte_16_9/cloud-storage/wp-thumbnails/corazon-rojo.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

