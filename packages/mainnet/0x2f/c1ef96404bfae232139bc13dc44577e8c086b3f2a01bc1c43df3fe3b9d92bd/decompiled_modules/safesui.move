module 0x2fc1ef96404bfae232139bc13dc44577e8c086b3f2a01bc1c43df3fe3b9d92bd::safesui {
    struct SAFESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFESUI>(arg0, 6, b"Safesui", b"Safe Sui", b"everyone remember the sucess of safemoon im every chain launched. And now it's time to fly again on Sui , LFG degens!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_08_002018_4ea60b956b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

