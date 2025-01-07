module 0x4e1002a0d6875b2fd2de476d57bd5accfbea480b66e59a4b07268e2621246be6::nas {
    struct NAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAS>(arg0, 6, b"NaS", b"Nasan contruction", b"Nasan Construction Co., Ltd is a dynamic and innovative construction company that specializes in delivering modern, high-quality building solutions. With a passion for excellence and a commitment to innovation, we bring fresh, creative designs to life, meeting the needs of todays fast-paced, evolving construction industry. Our experienced team of engineers and professionals ensures that every project is executed with precision, from initial concept to final completion. At Nasan Construction, we pride ourselves on building not just structures, but lasting relationships with our clients, ensuring satisfaction and trust every step of the way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7dae712d_7718_41b5_873f_42fafd925613_e184d326d7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

