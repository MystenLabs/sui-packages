module 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::main {
    fun main() {
        let v0 = 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::m333::make_s(vector[0, 1, 2, 3, 4]);
        let v1 = 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::m333::make_q<bool>(vector[true, false, true, false, true]);
        let v2 = 0;
        while (v2 < 5) {
            assert!(*0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::m333::borrow_s(&v0, v2) == v2, v2);
            assert!(*0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::m333::borrow_q<bool>(&v1, v2) == v2 % 2 == 0, v2 + 10);
            *0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::m333::borrow_s_mut(&mut v0, v2) = 0;
            *0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::m333::borrow_q_mut<bool>(&mut v1, v2) = true;
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 5) {
            assert!(*0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::m333::borrow_s(&v0, v2) == 0, v2 + 20);
            assert!(*0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::m333::borrow_q<bool>(&v1, v2), v2 + 30);
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

