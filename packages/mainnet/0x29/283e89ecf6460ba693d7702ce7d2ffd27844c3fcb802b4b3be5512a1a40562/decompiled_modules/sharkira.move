module 0x29283e89ecf6460ba693d7702ce7d2ffd27844c3fcb802b4b3be5512a1a40562::sharkira {
    struct SHARKIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKIRA>(arg0, 6, b"SHARKIRA", b"Shark Ira", b"$SHARKIRA lets out a Hips Dont Lie, swimming with the vibrant energy of La Tortura and the cunning of She Wolf. It's the most elegant predator in the ocean, conquering hearts and tokens while hitting the notes of Whenever, Wherever. With sharp claws and a superstar attitude, it will sing Waka Waka as it reaches the heights of SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_22_26_43_85f63d32ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

