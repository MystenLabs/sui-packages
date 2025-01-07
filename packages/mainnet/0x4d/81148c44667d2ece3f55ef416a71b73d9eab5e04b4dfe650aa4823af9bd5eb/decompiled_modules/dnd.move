module 0x4d81148c44667d2ece3f55ef416a71b73d9eab5e04b4dfe650aa4823af9bd5eb::dnd {
    struct DND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DND>(arg0, 6, b"Dnd", b"Dende", b"The elf of peace will take you to the hidden treasure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagen_de_Whats_App_2023_09_20_a_las_10_14_51_b925aa7f_4deefe8f4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DND>>(v1);
    }

    // decompiled from Move bytecode v6
}

