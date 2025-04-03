module 0xcb2c036e24cbee942a4a48abe95986002ab4e964d8baada96d26484b06ba30c1::swl {
    struct SWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWL>(arg0, 9, b"SWL", b"SWAL", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4568c533ddf13deed0a42bd5730c37a9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

