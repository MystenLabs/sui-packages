module 0xabbb7fe4c0127f30e5af4efebd485716bb995356555947ae72919db18e55499::delphina {
    struct DELPHINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELPHINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELPHINA>(arg0, 6, b"Delphina", b"Delphina Aquafina", b"Introducing $Delphina, the token that captures the essence of a singing dolphin whose melodies enchant the hearts of all sea creatures. With her unparalleled vocal talent, $Delphina makes waves in the ocean's depths, promoting a spectacle of joy and harmony. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_AAAA_Aaaa_AA_Aaa_AAA_Aaa_A_Aaa_A_3_02aea25171.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELPHINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELPHINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

