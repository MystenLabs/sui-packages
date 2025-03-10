module 0xfb2327625b47d24321e9464e68865d312a51ee5c63d208673b3d31d7b9facb62::dlove {
    struct DLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLOVE>(arg0, 9, b"DLOVE", b"DONATELOVE", b"Instead of donating fiat money, donate love cryptocurrency to charities. They will have to learn how to use the SUI blockchain to collect the money and in the process we will bring millions of people to SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75d431ed-b6b1-4f89-9f7b-210e26209d79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

