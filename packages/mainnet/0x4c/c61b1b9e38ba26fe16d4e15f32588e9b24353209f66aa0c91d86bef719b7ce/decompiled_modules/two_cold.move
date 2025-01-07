module 0x4cc61b1b9e38ba26fe16d4e15f32588e9b24353209f66aa0c91d86bef719b7ce::two_cold {
    struct TWO_COLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWO_COLD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TWO_COLD>(arg0, 15783459763938369537, b"Pipez2cold", b"2cold", b"Pipez iz 2 cold. No utility, just %100 grade A USDC certified Organic GAME. U think yu cold? Bisch u Luke warm at best. Pipez cold like your ex wife after she took the the cybertruk, the kids n the house + half ur monee.", b"https://images.hop.ag/ipfs/QmZde1wDmEFDhT4hhq1SFcmvNKzUddXgWbZU3DKk3eJniW", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

