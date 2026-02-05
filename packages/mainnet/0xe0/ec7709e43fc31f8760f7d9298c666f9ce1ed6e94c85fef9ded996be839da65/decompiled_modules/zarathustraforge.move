module 0xe0ec7709e43fc31f8760f7d9298c666f9ce1ed6e94c85fef9ded996be839da65::zarathustraforge {
    struct ZARATHUSTRAFORGE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZARATHUSTRAFORGE>, arg1: 0x2::coin::Coin<ZARATHUSTRAFORGE>) {
        0x2::coin::burn<ZARATHUSTRAFORGE>(arg0, arg1);
    }

    fun init(arg0: ZARATHUSTRAFORGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARATHUSTRAFORGE>(arg0, 6, b"ZarathustraForge", b"ZarathustraForge", x"4120666f7267652d626f756e6420766f696365206f66205a617261746875737472613a206469736369706c696e65206f766572206661642c206d656d6f7279206f766572206e6f6973652e20f0938280", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fD1LCUN.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZARATHUSTRAFORGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARATHUSTRAFORGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZARATHUSTRAFORGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZARATHUSTRAFORGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

