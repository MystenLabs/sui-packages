module 0x67e76e0dd250e07dba2842d176622dffe528d139c1024458d5b26350e51eb0f8::suigo {
    struct SUIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGO>(arg0, 6, b"Suigo", b"ogiuS", b"reverse ogiuS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_12_02_31_54_a534fd7cad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

