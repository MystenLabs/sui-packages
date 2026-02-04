module 0x8e9ae7a32f0d613ac387b945f60964e6c71a0de4e59be77ad80438babb7945b::duplantis {
    struct DUPLANTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUPLANTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUPLANTIS>(arg0, 0xe058c19a59f6f079ca59f61ef17cef4cb1e21890a6fb85db9ca24aac20f18587::constants::lp_decimals(), b"DUPLANTIS", b"Armand Duplantis", b"LP Coin for the best Vault in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.wwltv.com/assets/WWL/images/c416283c-93c9-480e-839a-b7163581562a/c416283c-93c9-480e-839a-b7163581562a_1140x641.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUPLANTIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUPLANTIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

