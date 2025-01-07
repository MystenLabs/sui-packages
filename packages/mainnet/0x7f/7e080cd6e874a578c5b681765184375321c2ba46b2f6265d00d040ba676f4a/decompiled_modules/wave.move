module 0x7f7e080cd6e874a578c5b681765184375321c2ba46b2f6265d00d040ba676f4a::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 6, b"WAVE", b"Wave Wallet", x"57617665206973206d6f7265207468616e20612077616c6c65742c206974277320616e2065636f73797374656d20666f722067616d657320616e6420442d617070732e200a0a57697468200a40537569466f756e646174696f6e0a20737570706f72742c2077652068616e646c65206d696c6c696f6e73206f66207472616e73616374696f6e73206461696c792077697468206c6f7720666565732c20656e68616e63696e67207573657220657870657269656e63652e20537461792074756e656420666f72206d6f7265206578636974696e6720666561747572657320696e20576176652057616c6c657421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ub_P8rz_Rm_400x400_removebg_preview_3e08b2ee6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

