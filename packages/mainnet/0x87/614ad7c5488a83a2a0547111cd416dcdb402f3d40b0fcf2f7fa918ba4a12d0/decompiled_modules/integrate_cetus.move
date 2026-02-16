module 0x87614ad7c5488a83a2a0547111cd416dcdb402f3d40b0fcf2f7fa918ba4a12d0::integrate_cetus {
    entry fun play() {
        let v0 = 0x1::string::utf8(b"Hello, World!");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

