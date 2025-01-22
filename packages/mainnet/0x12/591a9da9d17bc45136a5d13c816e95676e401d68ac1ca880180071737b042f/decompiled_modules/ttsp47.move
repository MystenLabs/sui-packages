module 0x12591a9da9d17bc45136a5d13c816e95676e401d68ac1ca880180071737b042f::ttsp47 {
    struct TTSP47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTSP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTSP47>(arg0, 6, b"TTSP47", b"TrumpTheSuperPresident", b"TRUMP47 is a groundbreaking cryptocurrency designed to celebrate the political legacy of Donald Trump, the 45th President of the United States. By leveraging blockchain technology, TRUMP47 establishes a decentralized platform that aligns with Trump's core principles, such as limited government and free-market economics. With a total supply of 1 billion tokens, TRUMP47 is more than just a digital asset; it's a movement that allows enthusiasts to express their support for Trump's ideals while participating in the digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_574957bde0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTSP47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTSP47>>(v1);
    }

    // decompiled from Move bytecode v6
}

