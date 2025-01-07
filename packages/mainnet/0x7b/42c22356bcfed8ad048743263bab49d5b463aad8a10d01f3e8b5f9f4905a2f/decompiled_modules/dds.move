module 0x7b42c22356bcfed8ad048743263bab49d5b463aad8a10d01f3e8b5f9f4905a2f::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDS>(arg0, 6, b"DDS", b"Dev Do Something", b"Why dip? What are the marketing plans? Is the dev active? Wen CMC? Need callers!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_5f83e15a24.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

