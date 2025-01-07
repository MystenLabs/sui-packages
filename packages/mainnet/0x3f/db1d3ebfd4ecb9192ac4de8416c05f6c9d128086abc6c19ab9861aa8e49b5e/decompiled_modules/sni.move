module 0x3fdb1d3ebfd4ecb9192ac4de8416c05f6c9d128086abc6c19ab9861aa8e49b5e::sni {
    struct SNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNI>(arg0, 6, b"SNI", b"SUINOMICS", b"SUINOMICS is the magical science of making money appear, disappear, and sometimes multiply, but mostly just making you wonder where it all went. It's the study", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L9re_Y5jd_400x400_48d72b9543.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

