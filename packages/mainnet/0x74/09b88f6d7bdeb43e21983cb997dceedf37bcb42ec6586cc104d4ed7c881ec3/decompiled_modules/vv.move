module 0x7409b88f6d7bdeb43e21983cb997dceedf37bcb42ec6586cc104d4ed7c881ec3::vv {
    struct VV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VV>(arg0, 9, b"VV", b"VVEST", b"VVEST is a sustainable cryptocurrency aimed at promoting eco-friendly initiatives. By supporting green projects and renewable energy solutions, VVEST empowers users to make a positive impact on the environment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d172f35b-b7b2-4399-8442-98e6f0da3e4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VV>>(v1);
    }

    // decompiled from Move bytecode v6
}

