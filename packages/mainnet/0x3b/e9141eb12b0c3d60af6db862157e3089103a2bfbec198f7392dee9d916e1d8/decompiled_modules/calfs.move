module 0x3be9141eb12b0c3d60af6db862157e3089103a2bfbec198f7392dee9d916e1d8::calfs {
    struct CALFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALFS>(arg0, 6, b"Calfs", b"Lucky Calfs", b"Lucky Calfs live life in their unique manner. \"Lucky Calfs\" is more than just a collection of calves; it represents a spirit and a lifestyle. In today's digital age, each Lucky Calf symbolizes a group of people who yearn for luck and success. Just as calves frolic in the meadows with a sense of vitality, these individuals seek to create their own destinies. The core values of Lucky Calfs are the pursuit of good fortune, an active lifestyle, and prosperity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000074126_f6bf54d683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CALFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

