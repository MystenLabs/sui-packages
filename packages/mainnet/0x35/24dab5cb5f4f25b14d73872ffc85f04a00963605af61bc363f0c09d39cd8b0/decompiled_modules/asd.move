module 0x3524dab5cb5f4f25b14d73872ffc85f04a00963605af61bc363f0c09d39cd8b0::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 6, b"ASD", b"Autism Spectrum Disorder", b"This image is dedicated to supporting individuals with Autism Spectrum Disorder (ASD) around the world. Through its soothing blue tones and gentle symbolism, it aims to promote awareness, understanding, and inclusivity. The adorable kitten represents the warmth, uniqueness, and individuality of those on the spectrum, celebrating their strengths and the beauty of diversity. Let this artwork serve as a reminder to create a more compassionate and supportive world for everyone. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ASD_01_e32e51ce29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

