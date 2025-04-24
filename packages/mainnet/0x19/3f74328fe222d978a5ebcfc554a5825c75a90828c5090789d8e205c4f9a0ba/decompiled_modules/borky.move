module 0x193f74328fe222d978a5ebcfc554a5825c75a90828c5090789d8e205c4f9a0ba::borky {
    struct BORKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORKY>(arg0, 6, b"BORKY", b"Sui Borky", b"Legend says BORKYs first bark caused a Base blockchain transaction to confirm instantly. Others say hes a dog with diamond paws. All we know is: if you hear a bork, something degen is about to happen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061876_47fdb47788.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

