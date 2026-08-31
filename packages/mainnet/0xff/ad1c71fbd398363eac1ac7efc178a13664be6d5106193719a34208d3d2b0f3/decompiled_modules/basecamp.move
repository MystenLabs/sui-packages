module 0xffad1c71fbd398363eac1ac7efc178a13664be6d5106193719a34208d3d2b0f3::basecamp {
    struct BASECAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASECAMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::FactoryReceipt<BASECAMP>>(0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::seal<BASECAMP>(arg0, 0x1::string::utf8(b"BASECAMP"), 0x1::string::utf8(b"basecamp"), 0x1::string::utf8(b"An unofficial test token created to commemorate Sui Basecamp 2026 in Singapore."), 0x1::string::utf8(b"https://images.lumacdn.com/cdn-cgi/image/format=auto,fit=cover,dpr=1,anim=false,background=white,quality=100,width=200,height=200/uploads/be/aa0f84fd-0ef3-47b5-925a-b4715856c69e.png"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

