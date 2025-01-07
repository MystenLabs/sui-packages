module 0xaf24354c3f3a9e110216d9642678cc793dca7c10990ddf9a7fda2ac69a06e580::ida03 {
    struct IDA03 has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDA03, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDA03>(arg0, 6, b"IDA03", b"Home", b"Original Oil Painting called Reflections of Home by Ida Fearn. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_12_at_18_32_47_fa4b45985d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDA03>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDA03>>(v1);
    }

    // decompiled from Move bytecode v6
}

