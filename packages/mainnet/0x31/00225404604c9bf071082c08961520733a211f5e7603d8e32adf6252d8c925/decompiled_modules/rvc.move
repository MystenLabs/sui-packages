module 0x3100225404604c9bf071082c08961520733a211f5e7603d8e32adf6252d8c925::rvc {
    struct RVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RVC>(arg0, 9, b"RVC", b"VetCoin", b"VetCoin: A Cryptocurrency for Veterans and Their Financial Well-Being VetCoin is a cryptocurrency designed specifically for veterans, providing a secure, accessible, and empowering way to manage their finances in the digital age. Built on blockchain technology, VetCoin offers a decentralized and transparent financial system that prioritizes the unique needs of veterans, including easier access to financial services, low-cost transactions, and enhanced security. Key Features: Veteran-Centered Ecosystem: VetCoin is tailored to veterans, offering access to exclusive benefits, discounts, and partnerships with veteran-friendly businesses, healthcare providers, and community organizations. Financial Inclusion: With its easy-to-use wallet and low transaction fees, VetCoin aims to include veterans who may have limited access to traditional banking services, ensuring financial freedom regardless of location or financial background.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RVC>(&mut v2, 75000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RVC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

