module 0x4a691022bfdfd030ab43ff468c43d5d4596c85aaab4527db662f754f55d5322f::suifemoon {
    struct SUIFEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFEMOON>(arg0, 6, b"SUIFEMOON", b"SUIfemoon", b"everyone remember the sucess of safemoon im every chain launched. And now it's time to fly again on Sui , LFG degens!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifemoon_501808b3e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

