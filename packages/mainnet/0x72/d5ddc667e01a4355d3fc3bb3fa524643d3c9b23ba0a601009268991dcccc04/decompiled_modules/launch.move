module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::launch {
    public fun btc() : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        crypto(b"BTC", @0xc729d56d7de4e22ad6e21f379f79c68d277a49789ac5b52b8df51ed16bc4a9a0, @0x2ee23ff1a76285979e5800a4097473f72d817ce678bc40b8143228799fefdcb3, 1, 1000, 100, 0, 1157299, 6109485000, 50000, 3000000000000, 1000000000000, 3000000000000, 90000000)
    }

    fun crypto(arg0: vector<u8>, arg1: address, arg2: address, arg3: u32, arg4: u64, arg5: u64, arg6: u8, arg7: u128, arg8: u128, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::listing(arg0, 0x2::object::id_from_address(arg1), 0x2::object::id_from_address(arg2), arg3, 10000, 15000, 6000, 50, 5, arg4, 500000000000000, 900000, arg13, arg11, arg11, arg12, 3000000000000, 100, arg7, arg8, arg9, 0, 1, arg10, 10000, 0, arg5, arg6)
    }

    public fun eth() : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        crypto(b"ETH", @0xd98176408c7341a5a3efe8a9a7babcb76df555ead88948ce3927cb4cb732a711, @0x28df607a554ddd13ce34a163b048df9f508f88f0a4dcdd02e0ea9c63c3a71b85, 2, 1000, 100, 0, 1983979, 7259685000, 50000, 1125000000000, 1000000000000, 3000000000000, 90000000)
    }

    public fun gold() : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        crypto(b"GOLD", @0x4b26e502f671cfcc560f1db495b17259dec2dcffdeefed00a8bdfc08a37129e2, @0x79e6018de20019c7fb577fb10cd7f906e935c1ce8da28e70935648062e16583d, 172, 1000, 100, 0, 1157299, 6109485000, 50000, 150000000000, 500000000000, 1000000000000, 90000000)
    }

    public fun googl() : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        crypto(b"GOOGL", @0x3de956675eb0038d48f0f59fac681df6ed80733076fb1cb911562171485b104f, @0xcfa52bf42be61e3c46284a2b4ff1a993a1b1bc5bf8929f6e0a972b3be67ba02c, 1163, 1000, 100, 1, 1157299, 6109485000, 50000, 100000000000, 500000000000, 1000000000000, 90000000)
    }

    public fun nvda() : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        crypto(b"NVDA", @0xc9c03df91207556078d643f4024e8ec3c132741c7979e2948fd0cb95fb496765, @0xe9049959effe686081dadff72743961c28dd1f8931e459b7659483e49e8813d6, 1314, 1000, 100, 1, 1157299, 6109485000, 50000, 125000000000, 500000000000, 1000000000000, 90000000)
    }

    public fun register_all<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::MarketRegistry, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: &mut 0x2::tx_context::TxContext) : vector<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>> {
        let v0 = 0x1::vector::empty<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>();
        0x1::vector::push_back<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(&mut v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::register_market<T0>(arg0, arg1, arg2, arg3, btc(), arg4));
        0x1::vector::push_back<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(&mut v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::register_market<T0>(arg0, arg1, arg2, arg3, eth(), arg4));
        0x1::vector::push_back<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(&mut v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::register_market<T0>(arg0, arg1, arg2, arg3, sol(), arg4));
        0x1::vector::push_back<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(&mut v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::register_market<T0>(arg0, arg1, arg2, arg3, sui(), arg4));
        0x1::vector::push_back<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(&mut v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::register_market<T0>(arg0, arg1, arg2, arg3, gold(), arg4));
        0x1::vector::push_back<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(&mut v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::register_market<T0>(arg0, arg1, arg2, arg3, nvda(), arg4));
        0x1::vector::push_back<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(&mut v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::register_market<T0>(arg0, arg1, arg2, arg3, tsla(), arg4));
        0x1::vector::push_back<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(&mut v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::register_market<T0>(arg0, arg1, arg2, arg3, googl(), arg4));
        0x1::vector::push_back<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(&mut v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::register_market<T0>(arg0, arg1, arg2, arg3, spcx(), arg4));
        let v1 = 10000000000000;
        let v2 = &mut v0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(v2)) {
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::set_oi_caps<T0>(0x1::vector::borrow_mut<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(v2, v3), arg2, arg3, v1, v1);
            v3 = v3 + 1;
        };
        v0
    }

    public fun sol() : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        crypto(b"SOL", @0x9112b09eed71b512afeee090b656ad5e279aaf83b91b34b04a6992b6e2740e42, @0xe8d7249c7f523a8da2ad57d045ed02c16abac8e6cea1705f4faf714cf80cb3db, 6, 1000, 100, 0, 1157299, 6109485000, 50000, 300000000000, 1000000000000, 2000000000000, 90000000)
    }

    public fun spcx() : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        crypto(b"SPCX", @0x2d426b09be9ab1d10e4f8c3709be68588002174608f61485173718ba1d39db9, @0x1c3dbc9bd30d71bb97b8cec64a4e2afa7dbd686129efa1f11bc8dfdf57f8f4e1, 3314, 1000, 100, 1, 1157299, 6109485000, 50000, 150000000000, 500000000000, 1000000000000, 90000000)
    }

    public fun sui() : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        crypto(b"SUI", @0xa963d9abc71d27918befc697d0b584aa7906fd8fa698e8c8d0e982acc288d97c, @0x1c48fd005399187fcdb76f88801e2b3aa13d0b02e7fbe30d6d5c563dd159638e, 11, 500, 50, 0, 3, 5000, 16000, 250000000000, 500000000000, 1000000000000, 45000000)
    }

    public fun tsla() : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Listing {
        crypto(b"TSLA", @0xf9e3d3600ec1626831a61d3b1a18137a6723d6034ec00361d1edf49e6c4b74de, @0x7efec925ca11e555fdb0d0955d7879088106256164317e2b28ea7188ade37c11, 1435, 1000, 100, 1, 1157299, 6109485000, 50000, 100000000000, 500000000000, 1000000000000, 90000000)
    }

    // decompiled from Move bytecode v7
}

