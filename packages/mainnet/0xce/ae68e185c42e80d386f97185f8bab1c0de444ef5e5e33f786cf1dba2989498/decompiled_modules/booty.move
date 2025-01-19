module 0xceae68e185c42e80d386f97185f8bab1c0de444ef5e5e33f786cf1dba2989498::booty {
    struct BOOTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOTY>(arg0, 6, b"BOOTY", b"BOOTY ON SUI", x"4368617274732075702c20626f6f7479206f75742e200a546861747320746865206f6e6c792074776f207468696e67732074686174206d617474657220776974682024424f4f545921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_Q_Gar_XW_400x400_bc751999a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

