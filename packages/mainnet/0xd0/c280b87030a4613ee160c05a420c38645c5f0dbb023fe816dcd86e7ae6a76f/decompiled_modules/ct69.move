module 0xd0c280b87030a4613ee160c05a420c38645c5f0dbb023fe816dcd86e7ae6a76f::ct69 {
    struct CT69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CT69>(arg0, 9, b"CT69", b"CAT69", b"TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b946577b81a7b1ef08e3be1be8fe6c2fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CT69>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT69>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

