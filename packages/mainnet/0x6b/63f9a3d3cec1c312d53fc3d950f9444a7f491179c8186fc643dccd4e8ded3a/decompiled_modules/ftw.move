module 0x6b63f9a3d3cec1c312d53fc3d950f9444a7f491179c8186fc643dccd4e8ded3a::ftw {
    struct FTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTW>(arg0, 9, b"FTW", b"FuckTheWar", b"Fuck the war in all world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/563d2def-6870-40c1-ba2c-63c9e1e86902-Screenshot_20241005-111338_Google.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

