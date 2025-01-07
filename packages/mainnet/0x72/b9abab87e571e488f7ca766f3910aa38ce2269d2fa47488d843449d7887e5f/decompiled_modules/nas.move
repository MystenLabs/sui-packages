module 0x72b9abab87e571e488f7ca766f3910aa38ce2269d2fa47488d843449d7887e5f::nas {
    struct NAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAS>(arg0, 6, b"NaS", b"Nasan contruction", b"Nasan Construction Co., Ltd is a dynamic and innovative construction company that specializes in delivering modern, high-quality building solutions. With a passion for excellence and a commitment to innovation, we bring fresh, creative designs to life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7dae712d_7718_41b5_873f_42fafd925613_e184d326d7_8174ca4a5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

