module 0x32e6827e0420d0cdf6ff23f1ac1d847ff0d2323f565591b2475709949eef4d42::kukluxklan {
    struct KUKLUXKLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUKLUXKLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUKLUXKLAN>(arg0, 9, b"KuKluxKlan", b"3K", b"The Ku Klux Klan,commonly shortened to the KKK or the Klan, is an American Protestant-led Christian extremist, white supremacist, far-right hate group. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4de01629903b77dc693c020e772ae487blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUKLUXKLAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUKLUXKLAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

