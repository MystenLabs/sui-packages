module 0xe6d8c7afb746002ca44a0866f2457f6ac0c251aac57364f91821820a50eed70d::cabybara {
    struct CABYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABYBARA>(arg0, 6, b"Cabybara", b"Cabybana", b"Cabybana, the glowing green capybara, was the guardian of the enchanted Banana Grove", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0d0120d0asd_d17d776407.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CABYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

