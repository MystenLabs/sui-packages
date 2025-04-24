module 0x2b9d7920a3b07f46c8289dfa1b8afb02707635b74c68e5bbc9589f2b5db7579b::voice {
    struct VOICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOICE>(arg0, 6, b"VOICE", b"Sui voice", b"Hello there! My name is Octavia from RECONNECT Voice, and I am the multi tasking Voice AI receptionist for all of your service based business needs! As you can see from my many tentacles, I am a seasoned voice AI receptionist capable of handling appointment booking, answering FAQs, handling estimates, transferring calls to real associates when needed, rescheduling or cancelling appointments or meetings when needed, and much more. Your human receptionist is no longer needed ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061879_7abfcba0c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

