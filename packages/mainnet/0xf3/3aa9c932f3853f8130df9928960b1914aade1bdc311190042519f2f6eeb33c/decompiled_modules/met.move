module 0xf33aa9c932f3853f8130df9928960b1914aade1bdc311190042519f2f6eeb33c::met {
    struct MET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MET>(arg0, 8, b"MET", b"METYA", b"World leading web3 AI social ecosystem. Combing #SocialFi, DePIN, AI, #RWA and PayFi.Over 10 million users gather here. Nice to MetYa, find $MET on CEX/DEX!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/655f6d18-ab93-4efa-87b7-3eaf3764c904.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MET>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MET>>(v1);
    }

    // decompiled from Move bytecode v6
}

