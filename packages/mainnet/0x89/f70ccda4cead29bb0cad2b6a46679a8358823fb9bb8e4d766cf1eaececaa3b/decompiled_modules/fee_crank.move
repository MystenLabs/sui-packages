module 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::fee_crank {
    public fun crank_fees<T0, T1, T2, T3: store, T4: drop, T5, T6>(arg0: &mut 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::Pool<T5, T6, T3, T4>, arg1: &mut 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::Bank<T0, T1, T5>, arg2: &mut 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::Bank<T0, T2, T6>) {
        let (v0, v1) = 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::collect_protocol_fees_<T5, T6, T3, T4>(arg0);
        0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::move_fees<T0, T1, T5>(arg1, v0);
        0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::move_fees<T0, T2, T6>(arg2, v1);
    }

    // decompiled from Move bytecode v6
}

