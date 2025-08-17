module 0xa104326a934c451916380de3bd528430417cb46c03a29d23fbf93243589e534::is {
    struct IS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IS>(arg0, 9, b"IS", b"IS_", b"Blast needs better Devs. It's an embarrassment!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IS>>(v2, @0x341e34c6e78efa411d91c73809eb5bee7669f5c9da0421de6dc21857f8b68f57);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IS>>(v1);
    }

    // decompiled from Move bytecode v6
}

