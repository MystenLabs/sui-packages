module 0x5c583242143635a203670164d5afff029c7b0f2a72ce670cbdb5bf032fcb3579::pluto {
    struct PLUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUTO>(arg0, 6, b"PLUTO", b"The Last Pluto", b"PLUTO the embodiment of belief, leading others to the promise of eternal pumps. Drink it juice and look only up! Sip this, Stay Dulo, stay long.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_f788baf77c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

