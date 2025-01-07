module 0x45656fa315fb9fb7fc11450c75b12c12b1d32bc464b4ec6c75516158bb2bfa5f::suicute {
    struct SUICUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUTE>(arg0, 6, b"Suicute", b"Suicute", b"Suicute pair launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS6D0-DlMVVJxByB-muBIHOEZw-RYiZI5FvQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICUTE>(&mut v2, 300000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUTE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

