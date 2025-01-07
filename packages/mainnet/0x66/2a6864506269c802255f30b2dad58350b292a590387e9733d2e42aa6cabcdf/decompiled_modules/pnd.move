module 0x662a6864506269c802255f30b2dad58350b292a590387e9733d2e42aa6cabcdf::pnd {
    struct PND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PND>(arg0, 9, b"PND", b"PandaCoin", b"The chillest coin in the jungle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3eb1672-7439-4bd1-be69-769af3080b7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PND>>(v1);
    }

    // decompiled from Move bytecode v6
}

