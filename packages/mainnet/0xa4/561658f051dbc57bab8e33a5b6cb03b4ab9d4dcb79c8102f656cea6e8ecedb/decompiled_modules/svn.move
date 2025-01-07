module 0xa4561658f051dbc57bab8e33a5b6cb03b4ab9d4dcb79c8102f656cea6e8ecedb::svn {
    struct SVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVN>(arg0, 9, b"SVN", b"Vietnamese", b"SVN is the coin of the Vietnamese community developed on the SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16a55b63-128b-4321-a247-8ae85b3b0207.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

