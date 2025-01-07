module 0xe56fe65bc87d9ffa3d24cbf6bcdc0478a42b860120456ba46b17110889217278::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FLY>(arg0, 590491287211237566, b"FLY", b"FLY", b"We about to Buzz", b"https://images.hop.ag/ipfs/QmdVRGnoANGctkqtn1hBRDoVuqxhAhvCXj54G7AZhu6GQe", 0x1::string::utf8(b"https://x.com/FlyOnSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/FlyOnSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

