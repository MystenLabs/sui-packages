module 0x1705606ff7b7706113844fb22a762d4d233a9d50b860aa903ba3645b74d0f922::ntc {
    struct NTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTC>(arg0, 9, b"NTC", b"NauticalCoin", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCQqmp6cmw9r4suGmaqpufkjF8_9cyec9CKA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NTC>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

