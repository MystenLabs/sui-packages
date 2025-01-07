module 0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::dex {
    public entry fun deposit_usdc(arg0: &mut 0x2::coin::Coin<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>(arg0) >= arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>>(0x2::coin::split<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>(arg0, arg2, arg3), arg1);
    }

    public entry fun deposit_usdc_content(arg0: &mut 0x2::coin::Coin<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>(arg0) >= arg1, 0);
        let v0 = 0x2::coin::split<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>(arg0, arg1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>>(0x2::coin::split<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>(&mut v0, arg1 * arg2 / 100, arg5), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>>(v0, arg3);
    }

    public entry fun deposit_usdc_content_aff(arg0: &mut 0x2::coin::Coin<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>(arg0) >= arg1, 0);
        let v0 = 0x2::coin::split<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>(arg0, arg1, arg7);
        let v1 = arg1 * arg2 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>>(0x2::coin::split<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>(&mut v0, v1, arg7), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>>(0x2::coin::split<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>(&mut v0, (arg1 - v1) * arg3 / 100, arg7), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaa5845b48efd2209d6087c75a31d9982e1070823aff8f8eb00c67c6c4063a0db::shareio::SHAREIO>>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

