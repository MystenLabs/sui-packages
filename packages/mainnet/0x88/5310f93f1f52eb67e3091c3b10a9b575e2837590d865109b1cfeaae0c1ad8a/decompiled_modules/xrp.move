module 0x885310f93f1f52eb67e3091c3b10a9b575e2837590d865109b1cfeaae0c1ad8a::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 6, b"XRP", b"Xtremely Rich People", b"We here at XTREMELY RICH PEOPLE focus only on a few things in life: stacking cash, buying lambos and being XTREMELY RICH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_140854_150_f913ad01f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

